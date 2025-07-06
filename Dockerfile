 # 1. Base Image
 # Using a slim, alpine-based Python image to keep the final image size small.
 # The project requires Python 3.10+, so 3.11 is a good and stable choice.
 FROM python:3.13.5-alpine3.22
 
 # 2. Set Working Directo  ry
 # This is where our application code will live inside the container.
 WORKDIR /app
 
 # 3. Copy and Install Dependencies
 # Copying requirements.txt first leverages Docker's layer caching.
 # If requirements.txt doesn't change, this layer won't be re-run on subsequent builds.
 COPY requirements.txt .
 
 # Install dependencies using pip.
 # --no-cache-dir reduces the image size by not storing the pip cache.
 RUN pip install --no-cache-dir -r requirements.txt
 
 # 4. Copy Application Code
 # Copy the rest of the application source code into the working directory.
 COPY . .
 
 # 5. Expose Port
 # Expose the port the application runs on. Uvicorn defaults to 8000.
 EXPOSE 8000
 
 # 6. Command
 # The command to run the application using uvicorn.
 # --host 0.0.0.0 is crucial to make the server accessible from outside the container.
 # The --reload flag from the readme is removed as it's for development, not production.
 CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
